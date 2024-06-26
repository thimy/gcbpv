require "rails_helper"

FactoryBot.define do
  factory :configuration do
    season_id { 1 }
  end
end

RSpec.describe Configuration do
  it "has a valid factory" do
    expect(build(:configuration)).to be_valid
  end

  it "does not allow another record to be created" do
    create(:configuration)
    config_2 = build(:configuration)

    expect(config_2.save).to be_falsey
  end

  it "does not allow destruction of the record" do
    config = create(:configuration)

    expect do
      config.destroy
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe ".load" do
    context "when a configuration record exists" do
      it "returns it" do
        config = create(:configuration)

        expect(described_class.load).to eq(config)
      end
    end

    context "when a configuration doesn't yet exist" do
      it "creates and returns a new one" do
        config = described_class.load

        expect(config).to be_a(Configuration)
      end
    end
  end
end
