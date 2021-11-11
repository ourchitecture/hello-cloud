using Microsoft.AspNetCore.Mvc;

namespace Ourchitecture.Hello.Cloud.Controllers;

[ApiController]
[Route("[controller]")]
public class HelloController : ControllerBase
{
  [HttpGet("/")]
  public String Get()
  {
    return "Hello cloud!";
  }
}
