package jp.matsu4512
{
	public class ColorHSV
	{
		public var h:Number, s:Number, v:Number;
		public function ColorHSV(h:Number, s:Number, v:Number)
		{
			this.h = h;
			this.s = s;
			this.v = v;
		}
		
		public function toRGB():ColorRGB{
			var f:Number;
			var i:int, p:int, q:int, t:int;
			var rgb:Array = [0,0,0];
			var v:Number = this.v*255, s:Number = this.s*255;
			
			i = int(Math.floor(h / 60.0)) % 6;
			f = Number(h / 60.0) - Number(Math.floor(h / 60.0));
			p = int(Math.round(v * (1.0 - (s / 255.0))));
			q = int(Math.round(v * (1.0 - (s / 255.0) * f)));
			t = int(Math.round(v * (1.0 - (s / 255.0) * (1.0 - f))));
			
			switch(i){
				case 0 : rgb[0] = v; rgb[1] = t; rgb[2] = p; break;
				case 1 : rgb[0] = q; rgb[1] = v; rgb[2] = p; break;
				case 2 : rgb[0] = p; rgb[1] = v; rgb[2] = t; break;
				case 3 : rgb[0] = p; rgb[1] = q; rgb[2] = v; break;
				case 4 : rgb[0] = t; rgb[1] = p; rgb[2] = v; break;
				case 5 : rgb[0] = v; rgb[1] = p; rgb[2] = q; break;
			}
			return new ColorRGB(-1, rgb[0], rgb[1], rgb[2]);
		}
	}
}