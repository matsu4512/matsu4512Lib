package jp.matsu4512.event
{
	import flash.events.Event;
	
	public class SliderEvent extends Event
	{
		public static const CHANGE:String = "change";
		public function SliderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}