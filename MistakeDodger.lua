MISTAKE_DODGER_GOLD_AMOUNT = 5000

local CORE_EVENTS = {
  "ADDON_LOADED"
}
MistakeDodgerCoreMixin = {}

function MistakeDodgerCoreMixin:OnLoad()
  FrameUtil.RegisterFrameForEvents(self, CORE_EVENTS)
end

function MistakeDodgerCoreMixin:OnEvent(eventName, name)
  if eventName == "ADDON_LOADED" and name == "MistakeDodger" then
    local BuyState = {
      WaitingForQuote = 1,
      PriceConfirmed = 2,
      PriceUpdated = 3,
      PriceUnavailable = 4,
      Purchasing = 5,
    }

    hooksecurefunc(AuctionHouseFrame.BuyDialog, "SetState", function(self, state)
      if state == BuyState.PriceUpdated or state == BuyState.PriceConfirmed then
        if not IsShiftKeyDown() and AuctionHouseFrame.BuyDialog.PriceFrame:GetAmount() > 100 * 100 * MISTAKE_DODGER_GOLD_AMOUNT then
          self.BuyNowButton:Disable()
          self.BuyNowButton:SetDisableTooltip(MISTAKE_DODGER_GOLD_AMOUNT .. "g!!!!!!!!!!!!!!!!!!")
        end
      end
    end)
  end
end
