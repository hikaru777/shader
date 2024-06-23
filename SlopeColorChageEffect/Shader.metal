//
//  shader.metal
//  SlopeColorChageEffect
//
//  Created by 本田輝 on 2024/06/23.
//

#include <metal_stdlib>
using namespace metal;


[[ stitchable ]] half4 slopeSeppenImage(float2 position, half4 color, float pitch, float roll) {
    
    float rightRoll = roll + 0.5;
    float leftRoll = roll - 0.5;
    // 傾き1の直線 y = x の位置を roll によって変える
    float scaledRoll1 = -rightRoll * 2000.0; // roll の値をスケールアップ
    float y_line1 = position.x + scaledRoll1;
    
    // もう一本の直線 y = x の位置を secondRoll によって変える
    float scaledRoll2 = -leftRoll * 2000.0; // secondRoll の値をスケールアップ
    float y_line2 = position.x + scaledRoll2;

    // 距離に基づいてオーバーレイの強度を計算
    float distance1 = abs(position.y - y_line1) / sqrt(1000.0);
    float intensity1 = exp(-distance1 * 0.5);
    
    float distance2 = abs(position.y - y_line2) / sqrt(1000.0);
    float intensity2 = exp(-distance2 * 0.5);
    
    float minDistance = min(distance1, distance2);

    // 距離に基づいてオーバーレイの強度を計算
    float intensity = exp(-minDistance * 0.2); // 強度を調整
    // オーバーレイの色を計算
    half4 overlayColor = half4(/*color.r + 0.8, color.g + 0.8, color.b + 0.8, */1,1,1,1);
    
    // 元の色とオーバーレイを合成
    half4 finalColor = mix(color, overlayColor, intensity * 0.6);
    
    return finalColor;
}

