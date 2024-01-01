#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;



uniform sampler2D texture;

uniform sampler2D texture1;
uniform sampler2D texture2;

uniform float cocktail_height;

uniform float mixed_percent;

uniform int ismixed;





void main(void) {
    
    

    
    float alpha;
    float border=0.3;
    
  
 
    vec2 uv;
  
    uv.x=vertTexCoord.x;
    uv.y=vertTexCoord.y;
    
    //vec3 col;
    
    vec3 col1 = texture2D(texture1, uv).rgb;
    vec3 col2 = texture2D(texture2, uv).rgb; //new_cocktail
    
    //이건, num_cocktail에 상관없이 동일!!
    if(uv.y>cocktail_height)
    {
        alpha=1.0;
        
    }
    
    else{
        alpha=0.0;
        
        
    }
    
    vec3 col=vec3(col1*col2);
    
 
    
    vec3 mixed_col1=mix(col2,col,mixed_percent);
   vec3 mixed_col2=mix(col1,col,mixed_percent);


    vec3 finalColor;
    
    if(ismixed==1)
{
    finalColor = (uv.y < border) ? mixed_col1 : mixed_col2;
}
    else{
        // uv.y가 border 미만이면 첫 번째 텍스처 사용, 그렇지 않으면 두 번째 텍스처 사용
        finalColor = (uv.y < border) ? col1 : col2;}
    
 
    
    gl_FragColor = vec4(finalColor,alpha);
    
  
}
