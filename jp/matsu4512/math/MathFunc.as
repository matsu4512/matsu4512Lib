package jp.matsu4512.math
{
	import flash.geom.Point;

	public class MathFunc
	{
		public static var EPS:Number = 0.000000001;
		
		public static function innerProduct(a:Point, b:Point):Number{
			return a.x*b.x+a.y*b.y;
		}
		
		public static function outerProduct(a:Point, b:Point):Number{
			return a.x*b.y-a.y*b.x;
		}
		
		public static function isIntersectsLines(a:Line, b:Line):Boolean {
			return (Math.abs(outerProduct(a.dir, b.dir)) > EPS || Math.abs(outerProduct(a.dir, b.pos.clone().subtract(a.pos))) < EPS);
		}
		
		public static function getLineCrossPoint(a:Line, b:Line):Point{
			var aa:Line = a.clone(), bb:Line = b.clone();
			var num:Number = outerProduct(bb.dir, bb.pos.clone().subtract(aa.pos));
			var denom:Number = outerProduct(bb.dir, aa.dir);
			aa.dir.x *= num/denom;
			aa.dir.y *= num/denom;
			return Point(aa.pos.clone().add(aa.dir));
		}
	}
}