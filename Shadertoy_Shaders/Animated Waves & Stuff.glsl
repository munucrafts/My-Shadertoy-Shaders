vec3 pixelAnim(vec2 uv, vec3 color, bool x, bool y)
{
    float waveX = 0.5 * sin(iTime + uv.x * 5.0) ;
    float waveY = 0.5 * sin(iTime + uv.y * 10.0) ;

    float yAnim = uv.y + waveX;
    float xAnim = uv.x + waveY;

    vec3 colX = (abs(yAnim) < 0.05 && x) ? color : vec3(0.0);
    vec3 colY = (abs(xAnim) < 0.05 && y) ? color : vec3(0.0);

    return colX + colY;
}

vec3 rect(vec2 uv, float size, vec3 col)
{
    vec2 mouse = iMouse.xy / iResolution.xy; 
    mouse -= 0.5;
    mouse *= 20.0;

    vec2 offset = vec2(mouse.x, mouse.y);

    vec3 colX = (abs(uv.y - offset.y) < size) ? col : vec3(0.0);
    vec3 colY = (abs(uv.x - offset.x) < size) ? col : vec3(0.0);
    
    return colX * colY;  
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv *= 15.0;
    uv.x *= iResolution.x / iResolution.y;
    
    vec3 col = pixelAnim(uv, vec3(1.0, 0.0, 0.0), false, true);
    
    col += pixelAnim(uv + vec2(0.0, 0.50), vec3(0.0, 1.0, 0.0), true, true);
    col += pixelAnim(uv + vec2(0.0, -0.50), vec3(0.0, 1.0, 1.0), true, false);
    
    vec3 rect = rect(uv, 3.5, vec3(0.5, 0.5, 0.95));

    fragColor = vec4(col + rect, 1.0);
}