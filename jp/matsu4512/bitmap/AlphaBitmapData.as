package jp.matsu4512.bitmap
{
	import flash.display.BitmapData;

	/**
	 * AlphaBitmapData
	 * 透明度がついていないBitmapDataを良い感じで透明度付きBitmapDataに変換する
	 */
	public class AlphaBitmapData extends BitmapData
	{
		/**
		 * コンストラクタ
		 * @param bitmapData 元画像
		 * @param alpha0 透明度の設定
		 * @param alpha1 透明度の設定
		 * @param alpha0Color この色に近いほど透明度がalpha0になる
		 * @param alpha1Color この色に近いほど透明度がalpha1になる
		 */
		public function AlphaBitmapData(bitmapData:BitmapData, alpha0:uint=0, alpha1:uint=255, alpha0Color:uint=0x000000, alpha1Color:uint=0xFFFFFF)
		{
			super(bitmapData.width, bitmapData.height, true, 0);
			
			var colorVector:Vector.<uint> = bitmapData.getVector(bitmapData.rect);
			var length:uint = colorVector.length;
			var alpha0R:uint = (alpha0Color>>16)&0xFF;
			var alpha0G:uint = (alpha0Color>>8)&0xFF;
			var alpha0B:uint = alpha0Color&0xFF;
			var alpha1R:uint = (alpha1Color>>16)&0xFF;
			var alpha1G:uint = (alpha1Color>>8)&0xFF;
			var alpha1B:uint = alpha1Color&0xFF;
			
			for(var i:int = 0; i < length; i++){
				var r:uint = (colorVector[i]>>16)&0xFF;
				var g:uint = (colorVector[i]>>8)&0xFF;
				var b:uint = colorVector[i]&0xFF;
				
				var alpha:int = ((r-alpha0R)/(alpha1R-alpha0R)+(g-alpha0G)/(alpha1G-alpha0G)+(b-alpha0B)/(alpha1B-alpha0B))/3*(alpha1-alpha0)+alpha0;
				if(alpha < alpha0) alpha = alpha0;
				else if(alpha > alpha1) alpha = alpha1;
				colorVector[i] = (alpha<<24) | (r<<16) | (g<<8) | b;
			}
			
			this.setVector(this.rect, colorVector);
		}
	}
}