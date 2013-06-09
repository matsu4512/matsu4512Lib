package jp.matsu4512.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import jp.matsu4512.color.ColorHSV;
	import jp.matsu4512.color.ColorRGB;
	
	public class Button extends Sprite
	{
		private var normalBtn:Bitmap;
		private var mouseOverBmp:Bitmap;
		private var mouseDownBmp:Bitmap;
		private var over:Boolean = false;
		private var _enabled:Boolean = true;
		private var tf:TextField;
		
		public function Button(x:Number, y:Number, width:Number, height:Number, label:String, fontSize:int=14, color:uint=0xAAAAAA, fontColor:uint=0, bold:Boolean=false)
		{
			super();
			this.x = x;
			this.y = y;
			buttonMode = true;
			
			var normalBmpd:BitmapData = new BitmapData(width, height, false, 0);
			var overBmpd:BitmapData = new BitmapData(width, height, false, 0);
			var downBmpd:BitmapData = new BitmapData(width, height, false, 0);
			
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = new TextFormat(null, fontSize, null, bold);
			tf.textColor = fontColor;
			tf.text = label;
			var sp:Sprite = new Sprite();
			sp.addChild(tf);
			tf.x = width/2-tf.width/2;
			tf.y = height/2-tf.height/2;
			tf.mouseEnabled = false;
			
			drawGradient(sp, width, height, color, 0.7);
			normalBmpd.draw(sp);
			normalBtn = new Bitmap(normalBmpd);
			
			drawGradient(sp, width, height, color, 0.5);
			overBmpd.draw(sp);
			mouseOverBmp = new Bitmap(overBmpd);
			
			drawGradient(sp, width, height, color, 0.3);
			downBmpd.draw(sp);
			mouseDownBmp = new Bitmap(downBmpd);
			
			addChild(normalBtn);
			addChild(mouseOverBmp);
			addChild(mouseDownBmp);
			mouseOverBmp.visible = mouseDownBmp.visible = false;
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function drawGradient(sp:Sprite, width:Number, height:Number, color:int, brightness:Number):void{
			sp.graphics.clear();
			var m:Matrix = new Matrix();
			var hsv:ColorHSV = new ColorRGB(color).toHSV();
			hsv.v = brightness;
			var color2:uint = hsv.toRGB().value;
			m.createGradientBox(width, height, Math.PI/2);
			sp.graphics.beginGradientFill(GradientType.LINEAR, [color, color2], [1, 1], [0, 255], m);
			sp.graphics.drawRect(0,0,width,height);
			sp.graphics.endFill();
		}
		
		public function set label(v:String):void{
			tf.text = v;
		}
		
		public function set enabled(v:Boolean):void{
			if(v){
				_enabled = true;
				normalBtn.visible = true;
				mouseDownBmp.visible = mouseDownBmp.visible = false;
				mouseEnabled = true;
			}
			else{
				_enabled = false;
				mouseOverBmp.visible = normalBtn.visible = false;
				mouseDownBmp.visible = true;
				mouseEnabled = false;
			}
		}
		
		public function set click(func:Function):void{
			addEventListener(MouseEvent.CLICK, func);
		}
		
		private function onMouseDown(e:MouseEvent):void{
			normalBtn.visible = false;
			mouseOverBmp.visible = false;
			mouseDownBmp.visible = true;
		}
		
		private function onMouseUp(e:MouseEvent):void{
			if(over){
				normalBtn.visible = false;
				mouseOverBmp.visible = true;
				mouseDownBmp.visible = false;
			}
			else{
				normalBtn.visible = true;
				mouseOverBmp.visible = false;
				mouseDownBmp.visible = false;
			}
		}
		
		private function onMouseOver(e:MouseEvent):void{
			normalBtn.visible = false;
			mouseOverBmp.visible = true;
			mouseDownBmp.visible = false;
			over = true;
		}
		
		private function onMouseOut(e:MouseEvent):void{
			normalBtn.visible = true;
			mouseOverBmp.visible = false;
			mouseDownBmp.visible = false;
			over = false;
		}
	}
}