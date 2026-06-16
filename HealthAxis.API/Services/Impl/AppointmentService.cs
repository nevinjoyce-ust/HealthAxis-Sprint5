using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Enums;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services;

namespace HealthAxis.API.Services.Impl;

public class AppointmentService(
    IAppointmentRepository appointmentRepository,
    IPatientRepository patientRepository,
    IDoctorRepository doctorRepository,
    IUserRepository userRepository,
    IMapper mapper) : IAppointmentService
{
    public async Task<List<AppointmentDto>> GetAllAppointmentsAsync()
    {
        var appointments = await appointmentRepository.GetAllAsync();

        var appointmentDtos = new List<AppointmentDto>();

        foreach (var appointment in appointments)
        {
            appointmentDtos.Add(await MapAppointmentToDtoAsync(appointment));
        }

        return appointmentDtos;
    }

    public async Task<AppointmentDto?> CreateAppointmentAsync(CreateAppointmentDto dto)
    {
        var patient = await patientRepository.GetByIdAsync(dto.PatientId);
        var doctor = await doctorRepository.GetByIdAsync(dto.DoctorId);

        if (patient == null || doctor == null)
        {
            return null;
        }

        if (!doctor.IsAvailable)
        {
            return null;
        }

        var appointment = new Appointment
        {
            PatientId = dto.PatientId,
            DoctorId = dto.DoctorId,
            AppointmentDate = dto.AppointmentDate,
            AppointmentTime = dto.AppointmentTime,
            Status = AppointmentStatus.Pending
        };

        var createdAppointment = await appointmentRepository.AddAsync(appointment);

        return await MapAppointmentToDtoAsync(createdAppointment);
    }

    public async Task<AppointmentDto?> UpdateAppointmentStatusAsync(int id, UpdateAppointmentStatusDto dto)
    {
        var appointment = await appointmentRepository.GetByIdAsync(id);

        if (appointment == null)
        {
            return null;
        }

        appointment.Status = dto.Status;
        appointment.CancellationReason = dto.CancellationReason;

        await appointmentRepository.UpdateAsync(appointment);

        return await MapAppointmentToDtoAsync(appointment);
    }

    public async Task<AppointmentDto?> DeleteAppointmentAsync(int id)
    {
        var deletedAppointment = await appointmentRepository.DeleteAppointmentAsync(id);
        if (deletedAppointment is null) return null;

        return await MapAppointmentToDtoAsync(deletedAppointment);
    }
    public async Task<List<AppointmentReportDto>> GetAppointmentReportsAsync()
    {
        var appointments = await appointmentRepository.GetAllAsync();

        return appointments
            .GroupBy(appointment => appointment.AppointmentDate)
            .Select(group => new AppointmentReportDto
            {
                Date = group.Key,
                ConfirmedCount = group.Count(a => a.Status == AppointmentStatus.Confirmed),
                CancelledCount = group.Count(a => a.Status == AppointmentStatus.Cancelled),
                CompletedCount = group.Count(a => a.Status == AppointmentStatus.Completed),
                PendingCount = group.Count(a => a.Status == AppointmentStatus.Pending),
                TotalCount = group.Count()
            })
            .OrderBy(report => report.Date)
            .ToList();
    }

    private async Task<AppointmentDto> MapAppointmentToDtoAsync(Appointment appointment)
    {
        var appointmentDto = mapper.Map<AppointmentDto>(appointment);

        var patient = await patientRepository.GetByIdAsync(appointment.PatientId);
        var doctor = await doctorRepository.GetByIdAsync(appointment.DoctorId);

        appointmentDto.PatientName = patient == null
            ? string.Empty
            : await userRepository.GetFullNameByIdAsync(patient.UserId) ?? string.Empty;

        appointmentDto.DoctorName = doctor == null
            ? string.Empty
            : await userRepository.GetFullNameByIdAsync(doctor.UserId) ?? string.Empty;

        return appointmentDto;
    }
}