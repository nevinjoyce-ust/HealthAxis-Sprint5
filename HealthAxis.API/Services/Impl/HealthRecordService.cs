using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Data;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.HealthRecord;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Services.Impl;

public class HealthRecordService(
    HealthAxisDbContext context,
    IHealthRecordRepository healthRecordRepository,
    IAppointmentRepository appointmentRepository,
    IMapper mapper) : IHealthRecordService
{
    public async Task<PagedResultDto<HealthRecordDto>> GetHealthRecordsByPatientIdAsync(
        int patientId,
        PaginationQueryDto pagination)
    {
        var records = await healthRecordRepository.GetHealthRecordsByPatientIdAsync(
            patientId,
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<HealthRecord, HealthRecordDto>(records);
    }

    public async Task<PagedResultDto<HealthRecordDto>> GetHealthRecordsForDoctorPatientViewAsync(
     int patientId,
     int doctorId,
     PaginationQueryDto pagination)
    {
        var hasConfirmedAppointment = await appointmentRepository
            .DoctorHasConfirmedAppointmentWithPatientAsync(doctorId, patientId);

        if (hasConfirmedAppointment)
        {
            return await GetHealthRecordsByPatientIdAsync(patientId, pagination);
        }

        return await GetHealthRecordsByPatientIdAndDoctorIdAsync(patientId, doctorId, pagination);
    }
    public async Task<PagedResultDto<HealthRecordDto>> GetHealthRecordsByPatientIdAndDoctorIdAsync(
        int patientId,
        int doctorId,
        PaginationQueryDto pagination)
    {
        var records = await healthRecordRepository.GetHealthRecordsByPatientIdAndDoctorIdAsync(
            patientId,
            doctorId,
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<HealthRecord, HealthRecordDto>(records);
    }

    public async Task<HealthRecordDto> GetHealthRecordByIdAsync(int id)
    {
        var record = await healthRecordRepository.GetHealthRecordByIdWithDetailsAsync(id);

        if (record == null)
        {
            throw new NotFoundException(ErrorMessages.HealthRecordNotFound);
        }

        return mapper.Map<HealthRecordDto>(record);
    }

    public async Task<HealthRecordDto> CreateHealthRecordAsync(CreateHealthRecordDto dto, int doctorId)
    {
        var appointment = await appointmentRepository.GetAppointmentByIdWithDetailsAsync(dto.AppointmentId);

        if (appointment == null)
        {
            throw new NotFoundException(ErrorMessages.AppointmentNotFound);
        }

        if (appointment.DoctorId != doctorId)
        {
            throw new ForbiddenException(ErrorMessages.DoctorCanCreateHealthRecordOnlyForOwnAppointment);
        }

        if (appointment.Status != AppointmentStatus.Confirmed)
        {
            throw new BusinessRuleException(ErrorMessages.OnlyConfirmedAppointmentsCanBeCompleted);
        }

        var today = DateOnly.FromDateTime(DateTime.Today);

        if (appointment.AppointmentDate != today)
        {
            throw new BusinessRuleException(ErrorMessages.HealthRecordCanBeCreatedOnlyOnAppointmentDate);
        }

        if (dto.VisitDate != appointment.AppointmentDate)
        {
            throw new BusinessRuleException(ErrorMessages.VisitDateMustMatchAppointmentDate);
        }

        var existingRecord = await healthRecordRepository.GetHealthRecordByAppointmentIdAsync(dto.AppointmentId);

        if (existingRecord != null)
        {
            throw new ConflictException(ErrorMessages.HealthRecordAlreadyExistsForAppointment);
        }

        await using var transaction = await context.Database.BeginTransactionAsync();

        try
        {
            var healthRecord = new HealthRecord
            {
                AppointmentId = dto.AppointmentId,
                VisitDate = dto.VisitDate,
                Diagnosis = dto.Diagnosis,
                Prescription = dto.Prescription,
                Notes = dto.Notes
            };

            var createdRecord = await healthRecordRepository.AddAsync(healthRecord);

            appointment.Status = AppointmentStatus.Completed;
            await appointmentRepository.UpdateAsync(appointment);

            await transaction.CommitAsync();

            var recordWithDetails = await healthRecordRepository.GetHealthRecordByIdWithDetailsAsync(createdRecord.Id);

            return recordWithDetails == null
                ? throw new NotFoundException(ErrorMessages.HealthRecordNotFoundAfterCreation)
                : mapper.Map<HealthRecordDto>(recordWithDetails);
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    private PagedResultDto<TDestination> MapPagedResult<TSource, TDestination>(PagedResult<TSource> pagedResult)
    {
        return new PagedResultDto<TDestination>
        {
            Items = mapper.Map<List<TDestination>>(pagedResult.Items),
            PageNumber = pagedResult.PageNumber,
            PageSize = pagedResult.PageSize,
            TotalCount = pagedResult.TotalCount,
            TotalPages = pagedResult.TotalPages
        };
    }
}
