with_fx :reverb, mix: 0.4 do
  with_fx :echo, mix: 0.8 do
    sample :ambi_swoosh, amp: 1
    sleep 2
    sample :ambi_lunar_land, rate: 2, release: 1.2, cutoff: 10
    sleep 1
  end
end

snaps = in_thread do
  loop do
    use_bpm 100
    sleep 1
    with_fx :reverb, mix: 0.6 do
      sample :perc_snap, amp: 1
    end
    sleep 1
  end
end


with_fx :reverb, mix: 0.4, room: 0.9 do
  use_synth :sine
  use_bpm 25
  1.times do
    use_synth :sine
    play_pattern_timed [(chord :F, :major7), (chord :D, :minor7), (chord :Bb, :major7), (chord :C, :"7")], [1,1,1,1], release: 1.5
    use_synth :fm
    #todo: put this on thread to play together as bass
    play_pattern_timed [(chord :F, :major7), (chord :F, :major7), (chord :F, :major7), (chord :F, :major7),
                        (chord :D, :minor7), (chord :D, :minor7), (chord :D, :minor7), (chord :D, :minor7),
                        (chord :Bb, :major7), (chord :Bb, :major7), (chord :Bb, :major7), (chord :Bb, :major7),
                        (chord :C, :"7"), (chord :C, :"7"), (chord :C, :"7"), (chord :C, :"7")], [0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25], release: 0.4
    use_synth :sine
    play_pattern_timed [(chord :G, :minor7), (chord :C, :"7"), (chord :F, :major7), (chord :C, :"7")], [1,1,1,1], release: 1.5
  end
end

snaps.kill

live_loop :drums do
  with_fx :reverb do
    use_bpm 95
    sample :drum_heavy_kick, cutoff: 80, amp: 4
    sleep 1
    sample :drum_heavy_kick, cutoff: 80, amp: 4
    sleep 0.75
    sample :drum_heavy_kick, cutoff: 80, amp: 4
    sleep 0.25
    sample :drum_heavy_kick, cutoff: 80, amp: 4
    sleep 1
    sample :drum_heavy_kick, cutoff: 80, amp: 4
    sleep 1
  end
end

chords = [(chord :C, :minor7), (chord :D, :minor7), (chord :Bb, :major7), (chord :C, "7")].ring
c = chords[0]
live_loop :bass do
  use_synth :fm
  use_octave -2
  3.times do
    play c[0] # play the chord's 1st note
    sleep 1
  end
  play c[2]
  sleep 0.5
  play c[1]
  sleep 0.5
  c = chords.tick
end

with_fx :reverb, mix: 0.4, room: 0.9 do
  use_bpm 25
  1.times do
    print("Start")
    play_pattern_timed [(chord :D, :major7), (chord :D, :minor7), (chord :F, :major7), (chord :C, :major7), (chord :Bb, :major7)], [0.5, 0.5, 1, 1, 1], release: 1.5
  end
  1.times do
    play_pattern_timed [(chord :D, :major), (chord :C, :major), (chord :A, :minor), (chord :c, :major), (chord :Bb, :major)], [1, 1, 0.25, 0.75, 1], release: 1.5
  end
  1.times do
    play_pattern_timed [(chord :D, :minor), (chord :F, :major), (chord :A, :minor), (chord :c, :major), (chord :Bb, :major)], [1, 1, 1, 1], release: 1.5
  end
end


use_bpm 100

live_loop :breakbeat do
  with_fx :slicer do
    sample :loop_breakbeat, beat_stretch: 4, amp: 2
    sleep 4
  end
end
