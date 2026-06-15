using HealthAxis.API.Data;
using HealthAxis.API.Repositories;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class Repository<T> : IRepository<T> where T : class
{
    protected readonly HealthAxisDbContext _context;
    protected readonly DbSet<T> _dbSet;

    public Repository(HealthAxisDbContext context)
    {
        _context = context;
        _dbSet = context.Set<T>();
    }

    public async Task<List<T>> GetAllAsync()
    {
        return await _dbSet.ToListAsync();
    }

    public async Task<T?> GetByIdAsync(int id)
    {
        return await _dbSet.FindAsync(id);
    }

    public async Task<T> AddAsync(T entity)
    {
        await _dbSet.AddAsync(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    public async Task<T?> UpdateAsync(T entity)
    {
        var exists = await _dbSet.FindAsync(
            entity.GetType().GetProperty("Id")?.GetValue(entity)
        );

        if (exists == null) return null;

        _dbSet.Update(entity);
        await _context.SaveChangesAsync();
        return entity;
    }

    public async Task<T?> DeleteAsync(int id)
    {
        var entity = await GetByIdAsync(id);
        if (entity == null) return null;

        _dbSet.Remove(entity);
        await _context.SaveChangesAsync();
        return entity;
    }
}