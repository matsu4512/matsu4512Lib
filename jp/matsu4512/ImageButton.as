package jp.matsu4512
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ImageButton extends Sprite
	{
		private var normalBmp:Bitmap;
		private var mouseOverBmp:Bitmap;
		private var mouseDownBmp:Bitmap;
		private var over:Boolean = false;
		private var _enabled:Boolean = true;
		
		public function ImageButton(normalBmp:Bitmap, overBmp:Bitmap, downBmp:Bitmap)
		{
			buttonMode = true;
			this.normalBmp = normalBmp;
			this.mouseOverBmp = overBmp;
			this.mouseDownBmp = downBmp;
			
			addChild(normalBmp);
			addChild(mouseOverBmp);
			addChild(mouseDownBmp);
			
			mouseOverBmp.visible = mouseDownBmp.visible = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function set enabled(v:Boolean):void{
			if(v){
				_enabled = true;
				normalBmp.visible = true;
				mouseDownBmp.visible = mouseDownBmp.visible = false;
				mouseEnabled = true;
			}
			else{
				_enabled = false;
				mouseOverBmp.visible = normalBmp.visible = false;
				mouseDownBmp.visible = true;
				mouseEnabled = false;
			}
		}
		
		public function set click(func:Function):void{
			addEventListener(MouseEvent.CLICK, func);
		}
		
		private function onMouseDown(e:MouseEvent):void{
			normalBmp.visible = false;
			mouseOverBmp.visible = false;
			mouseDownBmp.visible = true;
		}
		
		private function onMouseUp(e:MouseEvent):void{
			if(over){
				normalBmp.visible = false;
				mouseOverBmp.visible = true;
				mouseDownBmp.visible = false;
			}
			else{
				normalBmp.visible = true;
				mouseOverBmp.visible = false;
				mouseDownBmp.visible = false;
			}
		}
		
		private function onMouseOver(e:MouseEvent):void{
			normalBmp.visible = false;
			mouseOverBmp.visible = true;
			mouseDownBmp.visible = false;
			over = true;
		}
		
		private function onMouseOut(e:MouseEvent):void{
			normalBmp.visible = true;
			mouseOverBmp.visible = false;
			mouseDownBmp.visible = false;
			over = false;
		}
	}
}