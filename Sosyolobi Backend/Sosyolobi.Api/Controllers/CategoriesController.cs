using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Common;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/categories")]
public class CategoriesController : ControllerBase
{
    private readonly AppDbContext _db;

    public CategoriesController(AppDbContext db) => _db = db;

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var categories = await _db.ActivityCategories
            .Where(c => c.IsActive)
            .OrderBy(c => c.SortOrder)
            .Select(c => new { c.Id, c.Name, c.Slug, c.IconName, c.Color, c.SortOrder })
            .ToListAsync();

        return Ok(ApiResponse<object>.Ok(categories));
    }
}
