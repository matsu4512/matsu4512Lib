package jp.matsu4512.color
{
	/**
	 * RGBカラーを扱うクラス
	 * @author matsu4512
	 */
	public class ColorRGB
	{
		public var r:uint, g:uint, b:uint;
		
		/**
		 * コンストラクタ
		 * @param value 16進数で表した色、r,g,bで指定したい場合は-1を入れる
		 * @param r 赤成分 0～255
		 * @param g 緑成分 0～255
		 * @param b 青成分 0～255
		 */
		public function ColorRGB(value:int, r:int=-1, g:int=-1, b:int=-1)
		{
			if(value < 0){
				this.r = r;
				this.g = g;
				this.b = b;
			}
			else{
				this.value = value;
			}
		}
		
		/**
		 * 16進数で表されたRGB値の取得
		 * @return 16進数で表されたRGB値
		 */
		public function get value():int{
			return (r<<16) | (g<<8) | b;
		}
		
		/**
		 * 16進数で表されたRGB値のセット
		 * @param v 16進数で表されたRGB値
		 */
		public function set value(v:int):void{
			this.r = (v>>16)&0xFF;
			this.g = (v>>8)&0xFF;
			this.b = v&0xFF;
		}
		
		/**
		 * HSVColorに変換する
		 * @return HSVカラー
		 */
		public function toHSV():ColorHSV{
			var h:Number, s:Number, v:Number;
			var max:Number = Math.max(r, Math.max(g, b));
			var min:Number = Math.min(r, Math.min(g, b));
			
			// h
			if(max == min){
				h = 0;
			}
			else if(max == r){
				h = (60 * (g - b) / (max - min) + 360);
			}
			else if(max == g){
				h = (60 * (b - r) / (max - min)) + 120;
			}
			else if(max == b){
				h = (60 * (r - g) / (max - min)) + 240;   
			}
			if(h > 360) h -= 360;
			else if(h < 0) h += 360;
			
			// s
			if(max == 0){
				s = 0;
			}
			else{
				s = ((max - min) / max);
			}
			
			// v
			v = max/255;
			
			return new ColorHSV(h,s,v);
		}
	}
}