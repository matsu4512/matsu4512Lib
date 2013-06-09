package jp.matsu4512.progress
{
	import flash.display.GradientType;
	import flash.geom.Matrix;

	public class ProgressLine extends BaseProgress
	{
		public var w:Number, h:Number, color:uint;
		
		public var isGradation:Boolean=false;
		public var colors:Array, alphas:Array, ratios:Array;
		public var m:Matrix;
		
		public function ProgressLine(w:Number, h:Number, color:uint=0)
		{
			super();
			this.w = w;
			this.h = h;
			this.color = color;
		}
		
		public function setGradation(colors:Array):void{
			isGradation = true;
			this.colors = colors;
			alphas = [];
			ratios = [];
			for(var i:int = 0; i < colors.length; i++){
				alphas[i] = 1.0;
				ratios[i] = 255/(colors.length-1)*i;
			}
			m = new Matrix();
			m.createGradientBox(w, h);
		}
		
		override public function update():void{
			graphics.clear();
			if(!isGradation){
				graphics.beginFill(color);
				graphics.drawRect(0,0,w*progress,h);
				graphics.endFill();
			}
			else{
				graphics.beginGradientFill(GradientType.LINEAR,
					colors, alphas, ratios, m);
				graphics.drawRect(0,0,w*progress,h);
				graphics.endFill();
			}
		}
	}
}