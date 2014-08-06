class UFCFigther
  attr_reader :name, :weight, :wingspan, :strength
  
  def self.random_fighter
    UFCFighter.new({:name => Faker::Name.name,
                    :weight => rand(100..300),
                    :wingspan => rand(40..100),
                    :strength => rand(1..100)})
  end

  def initialize(options)
    defaults = {
      name: "nameless",
      weight: 170,
      wingspan: 84,
      strength: 50
    }
    @team = nil
    values = defaults.merge(options)
    @name = values[:name]
    @weight = values[:weight]
    @wingspan = values[:wingspan]
    @strength = values[:strength]
  end

  def train
    puts "grunt, sweat, grr"
    @strength += 1
    @weight -= 1
  end

  def consume_peds
    puts "yum, tastes like science"
    @wingspan += 10
    call_mom
  end

  def join_team team
    team.add_fighter self
  end


  protected
  attr_writer :weight, :strength, :wingspan

  private
  def call_mom
    puts "I love you, mom"
  end

end

class Team
  attr_reader :name, :fighters

  def initialize name
    @name = name
    @fighters = []
  end

  def add_fighter fighter
    @fighters << fighter
  end

  def heavyweights
    @fighters.select {|fighter| fighter.weight > 200}
  end

  def total_strength
    @fighters.inject(0) {|total, fighter| total + fighter.strength}
  end
end














