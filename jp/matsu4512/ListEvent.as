package jp.matsu4512
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class ListEvent extends Event
	{
		public static const SELECT:String = "select";
		
		public function ListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}