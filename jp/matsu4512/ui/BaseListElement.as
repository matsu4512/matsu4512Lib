package jp.matsu4512.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BaseListElement extends Sprite
	{
		public function BaseListElement()
		{
			super();
			addEventListener(MouseEvent.MOUSE_OVER, mover);
			addEventListener(MouseEvent.MOUSE_OUT, mout);
		}
		
		/**
		 * 選択時
		 */
		public function select():void{
		}
		
		/**
		 * 選択解除時
		 */
		public function unselect():void{
			
		}
		
		/**
		 * マウスオン時
		 */
		public function mover(e:MouseEvent):void{
			
		}
		
		/**
		 * マウスアウト時
		 */
		public function mout(e:MouseEvent):void{
			
		}
		
		public function getWidth():Number{
			return width;
		}
		
		public function getHeight():Number{
			return height;
		}
	}
}