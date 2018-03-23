class BoardController < ApplicationController
  before_action :authenticate_user!

  def random
    puts 'random #1'
    tempboard = Board.where(user_id: current_user.id)
    board = Board.find(tempboard.ids).last
    candidate_1 = board.users.first
    candidate_2 = board.users.last
    lock = board.lock
    if lock = 0
      ids = User.pluck(:id)
      ids.delete_if {|id| id == current_user.id }
      fate = ids.shuffle[0..1]
      board.user_ids = [fate[0], fate[1]]
      board.save
      puts 'random lock 0'
    elsif lock = 1
      ids = User.pluck(:id)
      ids.delete_if {|id| id == current_user.id }
      fate = ids.shuffle[0..1]
      fate[0] = candidate_1.id
      board.user_ids = [fate[0], fate[1]]
      board.save
      puts 'random lock 1'
    elsif lock = 2
      ids = User.pluck(:id)
      ids.delete_if {|id| id == current_user.id }
      fate = ids.shuffle[0..1]
      fate[1] = candidate_2.id
      board.user_ids = [fate[0], fate[1]]
      board.save
      puts 'random lock 2'
    end
    current_user.randomize = false
    current_user.save
    puts 'exiting random'
  end
 
  def show
    tempboard = Board.where(user_id: current_user.id)
    @board_id = Board.find(tempboard.ids).last.id

    if current_user.randomize == true
      self.random
    end
    tempboard = Board.where(user_id: current_user.id)
    board = Board.find(tempboard.ids).last
    @candidate_1 = board.users.first
    @candidate_2 = board.users.last
  end
 
##################################################################
 
  def next
    tempboard = Board.where(user_id: current_user.id)
    board = Board.find(tempboard.ids).last
    candidate_1 = board.users.first
    candidate_2 = board.users.last
    
    ab = ArchivedBoard.new(user_id: current_user.id)
    ab.user_ids=[candidate_1.id, candidate_2.id]
    ab.is_match = false
    ab.save
    
    current_user.randomize = true
    current_user.save

    #board.lock = params[:lock_client]
    #board.save!
    
    redirect_to root_path
  end
 
  def confirmation
    tempboard = Board.where(user_id: current_user.id)
    board = Board.find(tempboard.ids).last
    @candidate_1 = board.users.first
    @candidate_2 = board.users.last
  end
 
  def match
    tempboard = Board.where(user_id: current_user.id)
    board = Board.find(tempboard.ids).last
    candidate_1 = board.users.first
    candidate_2 = board.users.last
    
    ab = ArchivedBoard.new(user_id: current_user.id)
    ab.user_ids=[candidate_1.id, candidate_2.id]
    ab.is_match = true
    ab.save
    
    puts "\n#{candidate_1.firstname}'s karma before = #{Board.find(Board.where(user_id: current_user.id).ids).last.users.first.karma}\n"
    puts "#{candidate_2.firstname}'s karma before = #{Board.find(Board.where(user_id: current_user.id).ids).last.users.last.karma}\n"
    puts "#{current_user.firstname}(matchmaker) karma before = #{current_user.karma}"
    m = Match.new(user_id: current_user.id)
    m.user_ids=[candidate_1.id, candidate_2.id]
    candidate_1.karma += 1
    candidate_2.karma += 1
    candidate_1.save!
    candidate_2.save!
    m.save
    
    current_user.randomize = true
    current_user.karma += 2
    current_user.save

    board.lock = params[:lock_client]
    board.save!

    puts "\n#{candidate_1.firstname}'s karma after = #{Board.find(Board.where(user_id: current_user.id).ids).last.users.first.karma}\n"
    puts "#{candidate_2.firstname}'s karma after = #{Board.find(Board.where(user_id: current_user.id).ids).last.users.last.karma}\n"
    puts "#{current_user.firstname}(matchmaker) karma after = #{current_user.karma}"
    redirect_to root_path
  end
 
##################################################################
 
  def share
  end
 
  def index
  end
 
  def get_ids
  end
end
