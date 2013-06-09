package jp.matsu4512.ui
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import jp.matsu4512.event.SliderEvent;
	
	public class Slider extends Sprite
	{
		//つまみ
		protected var button:Sprite;
		//棒
		protected var bar:Sprite;
		
		protected var type:String;
		
		protected var _width:Number, _height:Number;
		public var _value:Number=0.5;
		
		public function Slider(type:String, x:Number, y:Number, width:Number, height:Number)
		{
			super();
			this.type = type;
			this.x = x;
			this.y = y;
			this._width = width;
			this._height = height;
			
			button = new Sprite();
			bar = new Sprite();
			button.buttonMode = true;
			addChild(bar);
			addChild(button);
			
			button.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			default_draw();
		}
		
		private function default_draw():void{
			button.graphics.beginFill(0xFFFFFF);
			button.graphics.lineStyle(1);
			if(type == "v")
				button.graphics.drawCircle(0,0,_width/2);
			else if(type == "h")
				button.graphics.drawCircle(0,0,_height/2);
			button.graphics.endFill();
			
			bar.graphics.beginFill(0x333333);
			bar.graphics.lineStyle(1);
			bar.graphics.drawRect(-_width/2, -_height/2, _width, _height);
			bar.graphics.endFill();
		}
		
		private function onMouseDown(e:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseUp(e:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void{
			if(type == "v"){
				button.y = bar.mouseY;
				if(button.y < -_height/2) button.y = -_height/2;
				else if(button.y > _height/2) button.y = _height/2;
				_value = 1.0-(button.y+_height/2)/_height;
			}
			else if(type == "h"){
				button.x = bar.mouseX;
				if(button.x < -_width/2) button.x = -_width/2;
				else if(button.x > _width/2) button.x = _width/2;
				_value = (button.x+_width/2)/_width;
			}
			dispatchEvent(new SliderEvent(SliderEvent.CHANGE));
		}
		
		public function plus__value(_value:Number):void{
			this._value += _value;
			set_button_position();
		}
		
		private function set_button_position():void{
			if(type == "v"){
				button.y = -_height/2+(1.0-_value)*_height;
			}
			else if(type == "h"){
				button.x = -_width/2+_value*_width;
			}
		}
		
		public function get value():Number{
			return _value;
		}
		
		public function set value(v:Number):void{
			this._value = v;
			set_button_position();
		}
	}
}