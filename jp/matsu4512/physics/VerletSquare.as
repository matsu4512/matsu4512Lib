package jp.matsu4512.physics
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class VerletSquare
	{
		public var points:Vector.<VerletPoint> = new Vector.<VerletPoint>();
		public var sticks:Vector.<VerletStick> = new Vector.<VerletStick>();
		
		/**
		 * x,y:位置
		 * width,height:横、縦幅
		 * n:頂点数 n=1で4頂点, n=2で8頂点, n=3で12頂点, …
		 * k:物体の軟らかさ。値が大きいほどやわい
		 */
		public function VerletSquare(x:Number, y:Number, width:Number, height:Number, n:int=1, k:Number=2)
		{
			points.push(new VerletPoint(x,y));
			var d:Number = width/n;
			for(var i:int = 1; i < n; i++)
				points.push(new VerletPoint(x+d*i,y));
			
			points.push(new VerletPoint(x+width,y));
			d = height/n;
			for(i = 1; i < n; i++)
				points.push(new VerletPoint(x+width,y+d*i));
			
			points.push(new VerletPoint(x+width,y+height));
			d = width/n;
			for(i = 1; i < n; i++)
				points.push(new VerletPoint(x+width-d*i,y+height));
			
			points.push(new VerletPoint(x,y+height));
			d = height/n;
			for(i = 1; i < n; i++)
				points.push(new VerletPoint(x,y+height-d*i));
			
			for(i = 0; i < points.length; i++){
				sticks.push(new VerletStick(points[i], points[(i+1)%points.length], -1, k));
				sticks.push(new VerletStick(points[i], points[(i+3)%points.length], -1, k));
				sticks.push(new VerletStick(points[i], points[(i+5)%points.length], -1, k));
			}
			
			var p:VerletPoint = new VerletPoint(x+width/2,y+height/2);
			for(i = 0; i < points.length; i++){
				sticks.push(new VerletStick(points[i], p, -1, k));
			}
			points.push(p);
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