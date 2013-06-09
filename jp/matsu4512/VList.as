package jp.matsu4512
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	public class VList extends List
	{
		public function VList()
		{
			super();
		}
		
		protected function updateSelectedIndex():void{
			selectedIndex = elements.indexOf(selectedItem);
		}
		
		/**
		 * リストのi番目に追加
		 * デフォルトは末尾に追加
		 */
		public function add(object:DisplayObject, i:int=-1):void{
			if(i == -1) elements.push(object);
			else elements = elements.slice(0,i-1).concat(object, elements.slice(i));
			object.addEventListener(MouseEvent.CLICK, onClick);
			updateSelectedIndex();
		}
		
		/**
		 * リストのi番目を削除
		 * デフォルトは末尾に追加
		 */
		public function remove(i:int):void{
			elements[i].removeEventListener(MouseEvent.CLICK, onClick);
			elements.splice(i,1);
			updateSelectedIndex();
		}
		
		/**
		 * リスト内の全要素を削除
		 */
		public function removeAll():void{
			for(var i:int = 0; i < elements.length; i++) 
				elements[i].removeEventListener(MouseEvent.CLICK, onClick);
			updateSelectedIndex();
		}
		
		public function get length():int{
			return elements.length;
		}
		
		protected function onClick(e:MouseEvent):void{
			var obj:DisplayObject = e.target;
			selectedItem = e.target;
			selectedIndex = elements.indexOf(e.target);
			dispatchEvent(new ListEvent(ListEvent.SELECT));
		}
	}
}