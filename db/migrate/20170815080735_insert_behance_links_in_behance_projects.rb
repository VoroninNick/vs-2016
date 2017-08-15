class InsertBehanceLinksInBehanceProjects < ActiveRecord::Migration
  def up
    arr = [
        [68, "https://www.behance.net/gallery/36839425/Plit-a-website-for-modern-metalworking-enterprise"],
        [70, "https://www.behance.net/gallery/36308605/Valko-custom-e-commerce-solution"],
        [71, "https://www.behance.net/gallery/47495619/Shuvar-info-full-responsive-website"],
        [73, "https://www.behance.net/gallery/38503207/Yantalia-bottle-label-and-logo-design"],
        [69, "https://www.behance.net/gallery/36390037/Arazzinni-e-commerce-solution"],
        [72, "https://www.behance.net/gallery/36637785/Millwood-website"]
    ]

    arr.each do |item|
      p = BehanceProject.find(item.first) rescue next
      p.behance_url = item.last
      p.save
    end
  end
end
