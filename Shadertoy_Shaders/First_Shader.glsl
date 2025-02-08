vec3 ColorPallete(float t)
{
    vec3 a = vec3(-3.142, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.0, 0.333, 0.667);
    
    return a + b * cos(6.28318 * (c * t + d));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{    
    vec2 uv = fragCoord / iResolution.xy;
    vec2 uv0 = uv;
    uv = ( uv - 0.5 ) * 2.0;
    uv.x = uv.x * iResolution.x / iResolution.y;
    
    vec3 finalColor = vec3(0.0, 0.0, 0.0);
    
    for(int i = 0; i <= 3; i++)
    {
        uv = fract(uv * 1.7);
        uv -= 0.5;

        float dist = length(uv);
        dist = sin(dist * 8.0 + iTime) / 8.0;
        dist = abs(dist);

        dist = 0.007 / dist;

        vec3 col = ColorPallete(length(uv0));
        finalColor += col * dist;
    }
    
    fragColor = vec4(finalColor, 1);
}
