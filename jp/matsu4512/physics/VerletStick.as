package jp.matsu4512.physics
{
	import flash.display.Graphics;

	public class VerletStick
	{
		private var pointA:VerletPoint, pointB:VerletPoint;
		private var length:Number;
		public var k:Number;
		
		public function VerletStick(pointA:VerletPoint, pointB:VerletPoint, length:Number=-1, k:Number=2)
		{
			this.k = k;
			this.pointA = pointA;
			this.pointB = pointB;
			if(length == -1){
				var dx:Number = pointA.x - pointB.x;
				var dy:Number = pointA.y - pointB.y;
				this.length = Math.sqrt(dx*dx+dy*dy);
			}
			else{
				this.length = length;
			}
		}
		
		public function update():void{
			var dx:Number = pointB.x - pointA.x;
			var dy:Number = pointB.y - pointA.y;
			var dist:Number = Math.sqrt(dx*dx+dy*dy);
			if(dist==0) dist = 0.001;
			var diff:Number = length-dist;
			var offsetX:Number = (diff*dx/dist)/k;
			var offsetY:Number = (diff*dy/dist)/k;
			pointA.x -= offsetX;
			pointA.y -= offsetY;
			pointB.x += offsetX;
			pointB.y += offsetY;
		}
		
		public function render(g:Graphics):void{
			g.lineStyle(0);
			g.moveTo(pointA.x, pointA.y);
			g.lineTo(pointB.x, pointB.y);
		}
	}
}