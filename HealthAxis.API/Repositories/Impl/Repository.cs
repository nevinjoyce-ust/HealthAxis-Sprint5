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

    protected static async Task<PagedResult<TResult>> ToPagedResultAsync<TResult>(
        IQueryable<TResult> query,
        int pageNumber,
        int pageSize)
    {
        var totalCount = await query.CountAsync();

        var items = await query
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();

        return new PagedResult<TResult>
        {
            Items = items,
            PageNumber = pageNumber,
            PageSize = pageSize,
            TotalCount = totalCount,
            TotalPages = (int)Math.Ceiling(totalCount / (double)pageSize)
        };
    }
}