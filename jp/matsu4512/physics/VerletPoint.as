package jp.matsu4512.physics
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;

	public class VerletPoint
	{
		public var x:Number, y:Number;
		public var oldX:Number, oldY:Number;
		
		public function VerletPoint(x:Number, y:Number)
		{
			setPosition(x,y);
		}
		
		public function update():void{
			var tempX:Number = x, tempY:Number = y;
			x += vx;
			y += vy;
			oldX = tempX;
			oldY = tempY;
		}
		
		public function setPosition(x:Number, y:Number):void{
			this.x = oldX = x;
			this.y = oldY = y;
		}
		
		public function constrain(rect:Rectangle):void{
			x = Math.max(rect.left, Math.min(rect.right, x));
			y = Math.max(rect.top, Math.min(rect.bottom, y));
		}
		
		public function set vx(value:Number):void{
			oldX = x-value;
		}
		
		public function get vx():Number{
			return x-oldX;
		}
		
		public function set vy(value:Number):void{
			oldY = y-value;
		}
		
		public function get vy():Number{
			return y-oldY;
		}
		
		public function render(g:Graphics):void{
			g.beginFill(0);
			g.drawCircle(x,y,4);
			g.endFill();
		}
	}
}