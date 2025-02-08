void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    uv -= 0.5;
    uv*= 2.0; 
    uv.x *= iResolution.x / iResolution.y;
    
    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 green = vec3(0.0, 1.0, 0.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);
    
    float dist = length(uv);
    float rad = 0.75;
    
    vec3 col = dist < rad ? mix(red, blue, tan(10.0 * abs(uv.x) * iTime)) : mix(blue, green, tan(100.0 * abs(uv.y) +  iTime));
    
    
    fragColor = vec4(col,1.0);
}