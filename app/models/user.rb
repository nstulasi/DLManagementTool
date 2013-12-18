require 'digest'
class User < ActiveRecord::Base
  has_many :memberships
  has_many :projects, :through => :memberships
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation
  
  accepts_nested_attributes_for :memberships,:allow_destroy=>true
  
  attr_accessor :project_user,:password,:password_confirmation
  
  attr_accessible :id,:name, :user_attributes, :email,:designations_attributes,:memberships_attributes,:homepage, :contact,:password,:password_confirmation, :invitation_token,:invitation_attributes

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true,
                  :length => {:maximum => 50}
  #validates :role, :presence => true,
   #               :length => {:maximum => 50},
    #              :if=>:should_not_validate_user
  validates :email, :presence =>true,
                  :format => {:with => email_regex},
                 :uniqueness => {:case_sensitive => false},
                :on => :create
                
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 },
                      :if => :should_validate_user,
                      :on=>:create
                      
   validates :password_confirmation, :presence=>true,:on=>:create,:if=>:should_validate_user
   validates_confirmation_of :password,:on=>:create,:if=>:should_validate_user
                       
   before_save :encrypt_password, :on=>:create,:if => :should_validate_user
  
  
  def invitation_token
    invitation.token if invitation
  end
  
  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end
 
 def self.get_csv(options = {})
    columns=["name","email","homepage","contact"]
  CSV.generate(options) do |csv|
    csv << ["Name","E-mail","Homepage","Contact"]
    all.each do |user|  
      csv << user.attributes.values_at(*columns)
    end
  end
end

def should_validate_user
  !project_user
end

def should_not_validate_user
  project_user
end

def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
end
  
  def self.authenticate(email, submitted_password)
    user=find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt==cookie_salt) ? user : nil 
  end
  
  def member_of(project)
    self.memberships.where(:project_id=>project.id).first
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
   
private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password=encrypt(password)
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
   
   def secure_hash(string)
     Digest::SHA2.hexdigest(string)
   end
  
end
