//
//  FlipCardView.swift
//  FlipCard
//
//  Created by 寒河江彪流 on 2024/02/04.
//

import SwiftUI

struct FlipCardView: View {
    // カードがめくられているかを管理する変数
    @State private var isCardFlipped: Bool = false
    // カードのめくられた角度
    @State private var degree: Double = 0.0
    // カードの面
    @State private var isShowFront: Bool = true
    // カードが半分めくられるまでの時間間隔
    private let duration : CGFloat = 0.2
    // カードの幅
    private let width : CGFloat = 260
    // カードの高さ
    private let height : CGFloat = 180
    
    var body: some View {
        // ZStack を返す
        ZStack {
            // 角の丸い長方形を配置
            RoundedRectangle(cornerRadius: 10)
            // 白で塗る
                .fill(.white)
            // 影をつける
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            // カードの面を生成
            if isShowFront {
                // 表面
                frontFace
            } else {
                // 裏面
                backFace
            } // if ここまで
        } // ZStack ここまで
        // 幅高さを指定
        .frame(width: width, height: height)
        // 回転エフェクトをつける
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        // タップされたら
        .onTapGesture {
            // カードをめくる
            flipCard()
        } // onTapGesture ここまで
    } // body ここまで
    
    // カードのオモテ面
    private var frontFace: some View {
        Text("オモテ")
    } // frontFace ここまで
    
    // カードのウラ面
    private var backFace: some View {
        Text("ウラ")
    } // backFace ここまで
    
    // カードをめくるメソッド
    private func flipCard() {
        // カードがめくられているか、めくられていないかを、切り替え
        isCardFlipped.toggle()
        // カードをめくるアニメーション
        withAnimation(.linear(duration: duration)) {
            degree = isCardFlipped ? 90 : 270
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                degree = isCardFlipped ? 270 : 90
                isShowFront.toggle()
                withAnimation(.linear(duration: duration)){
                    degree = isCardFlipped ? 360 : 0
                } // withAnimation ここまで
            } // DispatchQueue.main.asyncAfter ここまで
        } // withAnimation ここまで
    } // flipCard ここまで
} // FlipCardView ここまで

#Preview {
    FlipCardView()
}
