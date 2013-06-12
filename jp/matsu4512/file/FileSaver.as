package jp.matsu4512.file
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	public class FileSaver
	{
		private var fileReference:FileReference;
		private var onComplete:Function;
		
		public function FileSaver()
		{
			fileReference = new FileReference();
			fileReference.addEventListener(Event.COMPLETE, _onComplete);
			fileReference.addEventListener(Event.CANCEL, _onCancel);
		}
		
		public function save(byteArray:ByteArray, fileName:String, onComplete:Function=null):void{
			this.onComplete = onComplete;
			fileReference.save(byteArray, fileName);
		}
		
		private function _onComplete(e:Event):void{
			if(onComplete == null) return;
			onComplete.apply();
		}
		
		private function _onCancel(e:Event):void{
			
		}
	}
}