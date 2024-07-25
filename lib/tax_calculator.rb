module TaxCalculator
    TAX_RATES = {
      "Alberta" => { gst: 0.05, pst: 0, hst: 0, qst: 0 },
      "British Columbia" => { gst: 0.05, pst: 0.07, hst: 0, qst: 0 },
      "Manitoba" => { gst: 0.05, pst: 0.07, hst: 0, qst: 0 },
      "New Brunswick" => { gst: 0, pst: 0, hst: 0.15, qst: 0 },
      "Newfoundland and Labrador" => { gst: 0, pst: 0, hst: 0.15, qst: 0 },
      "Northwest Territories" => { gst: 0.05, pst: 0, hst: 0, qst: 0 },
      "Nova Scotia" => { gst: 0, pst: 0, hst: 0.15, qst: 0 },
      "Nunavut" => { gst: 0.05, pst: 0, hst: 0, qst: 0 },
      "Ontario" => { gst: 0, pst: 0, hst: 0.13, qst: 0 },
      "Prince Edward Island" => { gst: 0, pst: 0, hst: 0.15, qst: 0 },
      "Quebec" => { gst: 0.05, pst: 0, hst: 0, qst: 0.09975 },
      "Saskatchewan" => { gst: 0.05, pst: 0.06, hst: 0, qst: 0 },
      "Yukon" => { gst: 0.05, pst: 0, hst: 0, qst: 0 }
    }
  
    def self.calculate_tax(total_amount, province)
      rates = TAX_RATES[province] || { gst: 0, pst: 0, hst: 0, qst: 0 }
      gst = total_amount * (rates[:gst] || 0)
      pst = total_amount * (rates[:pst] || 0)
      hst = total_amount * (rates[:hst] || 0)
      qst = total_amount * (rates[:qst] || 0)
      gst + pst + hst + qst
    end
  end
  