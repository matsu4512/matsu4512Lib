package jp.matsu4512
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Utility
	{
		/**
		 * 配列、連想配列の中身を再帰的に出力する。
		 */
		public static function trace_array(obj:Object):void{
			for(var key:String in obj){
				var tab:String = "";
				trace(key + "⇒"+ obj[key]);
			}
		}
		
		/**
		 * nがk桁に満たない場合先頭に0をつけて文字列に変換する
		 */
		public static function intToString(n:int, k:int):String{
			var result:String = n.toString();
			while(result.length < k) result = "0"+result;
			return result;
		}
		
		/**
		 * 指定した大きさに収まるようにアスペクト比変更せずにリサイズする
		 * 入力:元のサイズ、最大サイズ
		 * 出力:リサイズ後のサイズ
		 */
		public static function resize(originalWidth:Number, originalHeight:Number, maxWidth:Number, maxHeight:Number):Point{
			var r:Number = Math.min(maxWidth/originalWidth, maxHeight/originalHeight);
			return new Point(originalWidth*r, originalHeight*r);
		}
		
		/**
		 * BitmapDataをrotation*90度回転させる。
		 */
		public static function rotateRightAngleBitmapData(bmpd:BitmapData, rotation:int):BitmapData{
			var w:Number, h:Number;
			if(rotation%2 == 0){
				w = bmpd.width;
				h = bmpd.height;
			}
			else{
				w = bmpd.height;
				h = bmpd.width;
			}
			var m:Matrix = new Matrix();
			m.translate(-bmpd.width/2, -bmpd.height/2);
			m.rotate(Math.PI/2*rotation);
			m.translate(w/2, h/2);
			var new_bmpd:BitmapData = new BitmapData(w, h, false);
			new_bmpd.draw(bmpd, m);
			return new_bmpd;
		}
		
		/**
		 * BitmapDataのリサイズ
		 */
		public static function resizeBitmapData(bmpd:BitmapData, width:Number, height:Number):BitmapData{
			var new_bmpd:BitmapData = new BitmapData(width, height, false);
			new_bmpd.draw(bmpd, new Matrix(width/bmpd.width, 0, 0, height/bmpd.height));
			return new_bmpd;
		}
		
		/**
		 * TextFieldの生成
		 */
		public static function createTextField(x:int, y:int, text:String, fontSize:Number, color:uint, font:String=null, bold:Object=null):TextField{
			var tf:TextField = new TextField();
			if(font != null) tf.embedFonts = true;
			tf.x = x;
			tf.y = y;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = new TextFormat(font, fontSize, null, bold);
			tf.textColor = color;
			tf.text = text;
			return tf;
		}
	}
}