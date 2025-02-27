class InvitationMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def send_invite(invitation, temporary_password = nil)
    @invitation = invitation
    @organization = invitation.organization
    @url = accept_invitation_organization_url(@organization, token: invitation.token)
    @temporary_password = temporary_password

    mail(to: @invitation.email, subject: "You have been invited to #{@organization.name}")
  end

  def existing_user_invite(user, organization)
    @user = user
    @organization = organization
    mail(to: @user.email, subject: "You've been added to #{@organization.name}")
  end

  def new_user_invite(invitation)
    @invitation = invitation
    @organization = invitation.organization
    @url = accept_invitation_organization_url(@organization, token: invitation.token)
    mail(to: @invitation.email, subject: "You have been invited to #{@organization.name}")
  end
end
