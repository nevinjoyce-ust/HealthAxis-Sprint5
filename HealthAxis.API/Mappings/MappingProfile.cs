using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Models;

namespace HealthAxis.API.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<Doctor, DoctorDto>()
            .ForMember(dest => dest.YearsOfExperience,
                opt => opt.MapFrom(src => src.CalculateYearsOfExperience()))
            .ForMember(dest => dest.FullName,
                opt => opt.Ignore());

        CreateMap<Patient, PatientDto>()
            .ForMember(dest => dest.FullName,
                opt => opt.Ignore());

        CreateMap<Appointment, AppointmentDto>()
            .ForMember(dest => dest.PatientName,
                opt => opt.Ignore())
            .ForMember(dest => dest.DoctorName,
                opt => opt.Ignore());

        CreateMap<CreateAppointmentDto, Appointment>();

        CreateMap<HealthRecord, HealthRecordDto>()
            .ForMember(dest => dest.PatientName,
                opt => opt.Ignore())
            .ForMember(dest => dest.DoctorName,
                opt => opt.Ignore());

        CreateMap<CreateHealthRecordDto, HealthRecord>();
    }
}