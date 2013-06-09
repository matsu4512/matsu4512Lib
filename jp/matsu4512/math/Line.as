package jp.matsu4512.math
{
	import flash.geom.Point;

	public class Line
	{
		public var pos:Point, dir:Point;
		public function Line(pos:Point, dir:Point)
		{
			this.pos = pos;
			this.dir = dir;
		}
		
		public function clone():Line{
			return new Line(pos.clone(), dir.clone());
		}
	}
}