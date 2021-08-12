require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe "pending_review" do
    let(:mail) { NotificationsMailer.pending_review }

    it "renders the headers" do
      expect(mail.subject).to eq("Pending review")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
