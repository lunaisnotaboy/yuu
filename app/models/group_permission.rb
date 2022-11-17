class GroupPermission < ApplicationRecord
  belongs_to :group_member, optional: false

  validates :permission, uniqueness: { scope: %i[group_member_id] }

  # Specifies which permission is provided by this.  Permissions are as follows:
  #
  #  * owner - has all permissions, can give owner status to another leader or
  #            delete the group
  #  * tickets - can view, respond to, and manage help desk requests
  #  * members - can invite and ban members
  #  * leaders - can edit permissions for other leaders (except owner)
  #  * community - can edit community settings (bio, cover, avatar, rules, etc.)
  #  * content - can manage posts and comments in the community
  #
  # @!attribute [rw] permission
  # @return [owner tickets members leaders community content]
  enum permission: { owner: 0, tickets: 1, members: 2, leaders: 3, community: 4,
                     content: 5 }

  scope :for_permission, ->(perm) { send(perm).or(owner) }
  scope :visible_for, ->(user) {
    # Only show permissions for members of groups you're a leader in
    where(group_member_id: GroupMember.leaders.for_user(user).select(:id))
  }

  after_create { group_member.regenerate_rank! }
  after_destroy { group_member.regenerate_rank! }

  before_destroy do
    false if owner? && group_member.group.owners.count == 1
  end
end
