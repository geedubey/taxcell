class SetUpFirstAdminUser < ActiveRecord::Migration
  def self.up
    #Be sure to change these settings for your initial admin user
    user = User.new
    user.login = "trysyn"
    user.email = "edateam@gmail.com"
    user.password = "trysyncommon"
    user.password_confirmation = "trysyncommon"
    user.state = "active"
    user.save(false)
    
    role = Role.new
    #Admin role name should be "admin" for convenience
    role.name = "owner"
    role.save
    admin_user = User.find_by_login("trysyn")
    admin_role = Role.find_by_name("owner")
    admin_user.activated_at = Time.now.utc
    admin_user.roles << admin_role
    admin_user.save(false)
  end
  
  def self.down
    admin_user = User.find_by_login("trysyn")
    admin_role = Role.find_by_name("owner")
    admin_user.roles = []
    admin_user.save
    admin_user.destroy
    admin_role.destroy
  end
end