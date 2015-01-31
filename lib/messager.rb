class Messager
  @msg_width = 500
  @msg_height = 220

  def self.message(text, color = $msg_white)
    $game_msgs.each do |msg|
      if $game_msgs.length > (@msg_height / 22).to_i
        $game_msgs.delete(msg)
      end
    end
    $game_msgs << text
  end

  def self.draw_messages(window)
    window.draw_quad(0, 800, $msg_black, @msg_width, 800, $msg_black, 0, 800 + @msg_height, $msg_black, @msg_width, 800 + @msg_height, $msg_black, 2)
    y = 800
    $game_msgs.each do |msg|
      $font.draw(msg, 5, y, 3, 1.0, 1.0, $msg_white)
      y += 20
    end
  end
end
