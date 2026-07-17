using AutoMapper;
using HealthAxis.API.Models;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Dtos.HealthRecord;
using HealthAxis.Shared.Dtos.Patient;

namespace HealthAxis.API.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        ConfigureDoctorMappings();
        ConfigurePatientMappings();
        ConfigureAppointmentMappings();
        ConfigureHealthRecordMappings();
    }

    private void ConfigureDoctorMappings()
    {
        CreateMap<Doctor, PublicDoctorDto>()
            .ForMember(dest => dest.YearsOfExperience,
                opt => opt.MapFrom(src => src.CalculateYearsOfExperience()));

        CreateMap<Doctor, DoctorDto>()
            .ForMember(dest => dest.YearsOfExperience,
                opt => opt.MapFrom(src => src.CalculateYearsOfExperience()))
            .ForMember(dest => dest.Email,
                opt => opt.MapFrom(src =>
                    src.User != null && src.User.Email != null
                        ? src.User.Email
                        : string.Empty))
            .ForMember(dest => dest.PhoneNumber,
                opt => opt.MapFrom(src =>
                    src.User != null && src.User.PhoneNumber != null
                        ? src.User.PhoneNumber
                        : string.Empty));
    }

    private void ConfigurePatientMappings()
    {
        CreateMap<Patient, PatientDto>()
            .ForMember(dest => dest.Email,
                opt => opt.MapFrom(src =>
                    src.User != null && src.User.Email != null
                        ? src.User.Email
                        : string.Empty))
            .ForMember(dest => dest.PhoneNumber,
                opt => opt.MapFrom(src =>
                    src.User != null && src.User.PhoneNumber != null
                        ? src.User.PhoneNumber
                        : string.Empty));
    }

    private void ConfigureAppointmentMappings()
    {
        CreateMap<Appointment, AppointmentDto>()
            .ForMember(dest => dest.PatientName,
                opt => opt.MapFrom(src =>
                    src.Patient != null
                        ? src.Patient.FullName
                        : string.Empty))
            .ForMember(dest => dest.DoctorName,
                opt => opt.MapFrom(src =>
                    src.Doctor != null
                        ? src.Doctor.FullName
                        : string.Empty))
            .ForMember(dest => dest.HealthRecordId,
                opt => opt.MapFrom(src =>
                    src.HealthRecord != null
                        ? src.HealthRecord.Id
                        : (int?)null));

        CreateMap<CreateAppointmentDto, Appointment>();
    }

    private void ConfigureHealthRecordMappings()
    {
        CreateMap<HealthRecord, HealthRecordDto>()
            .ForMember(dest => dest.PatientId,
                opt => opt.MapFrom(src =>
                    src.Appointment != null
                        ? src.Appointment.PatientId
                        : 0))
            .ForMember(dest => dest.DoctorId,
                opt => opt.MapFrom(src =>
                    src.Appointment != null
                        ? src.Appointment.DoctorId
                        : 0))
            .ForMember(dest => dest.PatientName,
                opt => opt.MapFrom(src =>
                    src.Appointment != null && src.Appointment.Patient != null
                        ? src.Appointment.Patient.FullName
                        : string.Empty))
            .ForMember(dest => dest.PatientAge,
                opt => opt.MapFrom(src => src.PatientAge))
            .ForMember(dest => dest.DoctorName,
                opt => opt.MapFrom(src =>
                    src.Appointment != null && src.Appointment.Doctor != null
                        ? src.Appointment.Doctor.FullName
                        : string.Empty));
    }
}
