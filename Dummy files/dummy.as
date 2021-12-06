package {

import flash.net.URLRequest;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

public class Main extends MovieClip {

		// timer for sound fade out
		private var soundFadeOutTimer:Timer = new Timer(100,50);
		private var fadeOutIncrement:Number = 0.1;
		
		// sounds, soundchannel objects and 
                private var channel:SoundChannel = new SoundChannel();
		private var loopMusic:Sound = new Sound();
		
		private var soundTransformObject = new SoundTransform(1, 0.0);
		
		
		public function Main() {

			// load sounds
			loopMusic.load(new URLRequest("assets/sound/soundtrack.mp3"));

			
			
			soundTransformObject.volume = 1;	// crank up the sound
			channel.soundTransform = soundTransformObject;	// apply the volume change from the soundTransform object
			
			channel = loopMusic.play();		// play the introMusic and use the channel object to control it
			channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);	// when intro is done let's get the main music loop happening.
			
			
		}
		
		private function soundCompleteHandler(e:Event)
		{
			trace("soundCompleteHandler");
			channel = loopMusic.play();		// play the loop music
			channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);		// when it's complete, play this loop again.		
		}
		
		public function fadeOutMusic()
		{
				soundFadeInterval = setInterval( function(channelReference) 	// channel is mapped to
																				// channelReference in this
																				// anonymous function
				{
					var vol = channelReference.soundTransform.volume;			// vol is a reference
					vol -= 0.025;												// decrement the vol variable
					if(vol <= 0) {												// keep above 0. What would a negative volume sound like?
						if(soundFadeInterval != null) 							// if not null...
						{
							clearInterval(soundFadeInterval);					// clearInterval
						}
						soundFadeInterval = null;								// it should now be null
						channelReference.stop();								// stop that channel playing
						trace("SoundChannel stopped");
					} 
					else 														// if we are not yet silent already
					{
						soundTransformObject.volume = vol;						// apply the decrement to the
																				// soundTransformObject
						channelReference.soundTransform = soundTransformObject;	// apply the sound transformation
																				// to the channel by setting the
																				// sound transform object to the
																				// soundTransform property.
																				// Anyone else think this is far
																				// too many objects for a simple
																				// operation?
						trace("Volume: " + channelReference.soundTransform.volume);	// let's trace this just in case
					}
				}, 50, channel); 	// the setInterval function take the arguments of actual intervals and the 
									// argument for that nice neat anonymous function I slipped in there.
				
				
				
			}
		}
		
	}

}
