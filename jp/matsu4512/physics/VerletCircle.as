package jp.matsu4512.physics
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class VerletCircle
	{
		public var points:Vector.<VerletPoint> = new Vector.<VerletPoint>();
		public var sticks:Vector.<VerletStick> = new Vector.<VerletStick>();
		
		public function VerletCircle(x:Number, y:Number, radius:Number, n:int, k:Number=2)
		{
			for(var i:int = 0; i < n; i++){
				points.push(new VerletPoint(Math.cos(2*Math.PI/n*i)*radius+x, Math.sin(2*Math.PI/n*i)*radius+y));
			}
			
			for(i = 0; i < n; i++){
				sticks.push(new VerletStick(points[i], points[(i+1)%n], -1, k));
				sticks.push(new VerletStick(points[i], points[(i+3)%n], -1, k));
				sticks.push(new VerletStick(points[i], points[(i+5)%n], -1, k));
			}
			
			points.push(new VerletPoint(x,y));
			for(i = 0; i < n; i++){
				sticks.push(new VerletStick(points[i], points[n], -1, k));
			}
		}
		
		public function constrain(rect:Rectangle):void{
			for(var i:int = 0; i < points.length; i++)
				points[i].constrain(rect);
		}
		
		public function update():void{
			for(var i:int = 0; i < points.length; i++)
				points[i].update();
			for(i = 0; i < sticks.length; i++)
				sticks[i].update();
		}
		
		public function render_architecture(g:Graphics):void{
			for(var i:int = 0; i < points.length; i++)
				points[i].render(g);
			for(i = 0; i < sticks.length; i++)
				sticks[i].render(g);
		}
		
		public function render_bezier(g:Graphics):void{
			g.beginFill(0);
			g.moveTo((points[points.length-2].x+points[0].x)*0.5, (points[points.length-2].y+points[0].y)*0.5);
			for(var i:int = 0; i < points.length-1; i++){
				var j:int = i+1;
				if(i == points.length-2) j = 0;
				var p1:VerletPoint = points[i], p2:VerletPoint = points[j];
				var p3:Point = new Point((p1.x+p2.x)*0.5, (p1.y+p2.y)*0.5);
				g.curveTo(p1.x, p1.y, p3.x, p3.y);
			}
			g.curveTo(points[points.length-2].x, points[points.length-2].y, (points[points.length-2].x+points[0].x)*0.5, (points[points.length-2].y+points[0].y)*0.5);

			g.endFill();
		}
		
		public function addVx(value:Number):void{
			for(var i:int = 0; i < points.length; i++){
				points[i].oldX = points[i].x-value;
			}
		}
		
		public function addVy(value:Number):void{
			for(var i:int = 0; i < points.length; i++){
				points[i].oldY = points[i].y-value;
			}
		}
	}
}