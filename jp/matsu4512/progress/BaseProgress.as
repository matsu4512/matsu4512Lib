package jp.matsu4512.progress
{
	import flash.display.Sprite;
	
	public class BaseProgress extends Sprite
	{
		private var _progress:Number;
		
		public function BaseProgress()
		{
			super();
		}
		
		public function set progress(value:Number):void{
			_progress = value;
			update();
		}
		
		public function get progress():Number{
			return _progress;
		}
		
		public function update():void{
			
		}
	}
}