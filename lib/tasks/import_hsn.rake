namespace :import do
  desc "Import HSN data from CSV files"
  task hsn: :environment do
    require "csv"

    csv_dir = Rails.root.join("db", "gst_rates")

    # Loop through all CSV files in the directory
    Dir.glob(csv_dir.join("*.csv")).each do |file_path|
      puts "Importing #{File.basename(file_path)}..."

      CSV.foreach(file_path, headers: true, encoding: "utf-8") do |row|
        # Map the CSV columns to your Hsn model attributes
        # The keys below must match the CSV header names exactly
        # next if file_path.split("/").last != "chapter-99-services-sac-code-gst-rate.csv"
        hsn_attributes = {}
        if file_path.split("/").last == "chapter-99-services-sac-code-gst-rate.csv"
          hsn_attributes = {
            code:       row["SAC Code"],
            description:    row["Description of Services"],
            chapter_heading: file_path.split("/").last,
            cess:           row["CESS (%)"]
          }
        else
          hsn_attributes = {
            code:       row["HSN Code"],
            description:    row["Description"],
            chapter_heading: file_path.split("/").last,
            gst:           row["Rate (%)"].to_f,
            sgst:           row["Rate (%)"].to_f/2,
            cgst:           row["Rate (%)"].to_f/2,
            cess:           row["CESS (%)"]
          }
        end
        # Create the record
        Hsn.create!(hsn_attributes)
      end

      puts "#{File.basename(file_path)} imported successfully."
    end

    puts "All files imported."
  end
end
