vec3 Checkerboard(vec2 uv)
{
    float checkSize = 0.2;
    vec2 grid = floor(uv / checkSize);
    float checker = mod(grid.x + grid.y, 2.0);

    vec3 color1 = vec3(0.9, 0.4, 0.0); 
    vec3 color2 = vec3(0.0, 0.4, 0.9); 

    return mix(color1, color2, checker);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 2.0;
    uv.x *= iResolution.x / iResolution.y;

    vec3 col = Checkerboard(uv);

    fragColor = vec4(col,1.0);
}