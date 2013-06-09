package jp.matsu4512.event
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ScalingMenuEvent extends Event
	{
		public static const CLICK:String = "ScalingMenuClick";
		public static const MOUSE_OVER:String = "ScalingMenuMouseOver";
		public static const MOUSE_OUT:String="ScalingMenuMouseOut";
		public var selectedIndex:int;
		public var fromIndex:int;
		public var selectedObject:Sprite;
		
		public function ScalingMenuEvent(type:String, selectedIndex:int, fromIndex:int, selectedObject:Sprite, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.fromIndex = fromIndex;
			this.selectedIndex = selectedIndex;
			this.selectedObject = selectedObject;
		}
	}
}