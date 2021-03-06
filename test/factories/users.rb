Factory.define :user do |f|
  f.name   'Basic User'
  f.github 'generic'
  f.email  'someone@somewhere.com'
  f.uid    '123'
end

Factory.define :admin, :class => User do |f|
  f.name   'Admin User'
  f.github 'kingkong'
  f.email  'bingo@bongo.com'
  f.admin  true
  f.uid    '456'
end

Factory.define :bart, :class => User do |f|
  f.name   'Bart Simpson'
  f.github 'bartsimpson'
  f.email  'faker@mcfakerstein.com'
  f.uid    '789'
end