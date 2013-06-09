package jp.matsu4512.progress
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class ProgressCircle extends BaseProgress
	{
		public var r:Number, color:uint, size:Number;
		
		public var isGradation:Boolean=false;
		private var gradationMap:Array = [];
		
		public function ProgressCircle(r:Number, size:Number, color:uint)
		{
			super();
			this.r = r;
			this.size = size;
			this.color = color;
		}
		
		override public function update():void{
			graphics.clear();
			graphics.lineStyle(size, color);
			graphics.moveTo(r*Math.cos(-Math.PI/2), r*Math.sin(-Math.PI/2));
			var n:int = progress*100;
			for(var i:int = 1; i <= n; i++){
				graphics.lineTo(r*Math.cos(2*Math.PI/100*i-Math.PI/2), r*Math.sin(2*Math.PI/100*i-Math.PI/2));
			}
		}
	}
}