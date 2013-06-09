package jp.matsu4512
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class List extends Sprite
	{
		protected var elements:Vector.<BaseListElement> = new Vector.<BaseListElement>();
		public var selectedIndex:int=-1;
		public var selectedItem:BaseListElement=null;
		private var container:Sprite = new Sprite();
		private var slider:Slider; 
		private var w:Number, h:Number;
		private var contentsHeight:Number=0;
		
		public function List(width:Number, height:Number)
		{
			super();
			this.w = width;
			this.h = height;
			addChild(container);
			
			slider = new Slider("v", w-15, 160, 10, 300);
			slider.value = 1;
			slider.addEventListener(SliderEvent.CHANGE, onSliderChange);
			addChild(slider);
			
			var mask:Sprite = new Sprite();
			mask.graphics.beginFill(0);
			mask.graphics.drawRect(0,0,width,height);
			mask.graphics.endFill();
			this.mask = mask;
			addChild(mask);
		}
		
		protected function onSliderChange(e:SliderEvent):void{
			adjustContainerPosition();
		}
		
		protected function adjustSliderButtonPosition():void{
			var ww:Number = contentsHeight-h;
			var r:Number = 1+container.y/ww;
			if(r > 1) slider.value = 1;
			else if(r < 0) slider.value = 0;
			else slider.value = r;
			adjustContainerPosition();
		}
		
		protected function adjustContainerPosition():void{
			var ww:Number = contentsHeight-h;
			container.y = -ww*(1-slider.value);
		}
		
		protected function updateSelectedIndex():void{
			selectedIndex = elements.indexOf(selectedItem);
		}
		
		/**
		 * リストのi番目に追加
		 * デフォルトは末尾に追加
		 */
		public function add(object:BaseListElement, i:int=-1):void{
			if(i == -1) {
				elements.push(object);
				i = elements.length-1;
			}
			else elements = elements.slice(0,i-1).concat(object, elements.slice(i));
			object.addEventListener(MouseEvent.CLICK, onClick);
			updateSelectedIndex();
			
			container.addChild(object);
			if(i > 0){
				object.y = elements[i-1].y+elements[i-1].getHeight();
			}
			for(var j:int = i+1; j < elements.length; j++){
				elements[j] += object.getHeight();
			}
			contentsHeight+=object.getHeight();
			adjustSliderButtonPosition();
		}
		
		/**
		 * リストのi番目を削除
		 * デフォルトは末尾に追加
		 */
		public function remove(i:int):void{
			container.removeChild(elements[i]);
			elements[i].removeEventListener(MouseEvent.CLICK, onClick);
			
			for(var j:int = i+1; j < elements.length; j++){
				elements[j].y -= elements[i].getHeight();
			}
			contentsHeight -= elements[i].getHeight();
			elements.splice(i,1);
			updateSelectedIndex();
			adjustSliderButtonPosition();
		}
		
		/**
		 * 要素を指定して削除
		 */
		public function removeByItem(elem:BaseListElement):void{
			var i:int = elements.indexOf(elem);
			if(i == -1) return;
			remove(i);
		}
		
		/**
		 * 要素の番号を取得
		 */
		public function indexOfElement(elem:BaseListElement):int{
			return elements.indexOf(elem);
		}
		
		/**
		 * リスト内の全要素を削除
		 */
		public function removeAll():void{
			for(var i:int = 0; i < elements.length; i++) 
				elements[i].removeEventListener(MouseEvent.CLICK, onClick);
			updateSelectedIndex();
			contentsHeight = 0;
		}
		
		/**
		 * 要素を取得
		 */
		public function getItem(i:int):BaseListElement{
			return elements[i];
		}
		
		public function get length():int{
			return elements.length;
		}
		
		protected function onClick(e:MouseEvent):void{
			if(!(e.target is BaseListElement)) return; 
			var obj:BaseListElement = e.target as BaseListElement;
			selectedItem = e.target as BaseListElement;
			selectedIndex = elements.indexOf(e.target);
			dispatchEvent(new ListEvent(ListEvent.SELECT));
		}
	}
}