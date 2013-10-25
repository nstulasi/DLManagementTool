module MetaHelper
  def xmler(xml,type,type_encoding)
       type.each_with_index do |t,index|
      if !params[t].nil?
         xml.type{
           node = xml.name{
             xml.text t
           }
           node['checked']='true'
           if !params[type_encoding[index]].nil?
               params[type_encoding[index]].each_pair do |key, value|
                xml.encoding { xml.text value }
              end
           end
         }
       else
         xml.type{
           xml.name(:checked=>"false"){
             xml.text t}
           }
       end
    end
  end 
  
  def service_xmler(xml)
    services.each_with_index do |s,i|
      if !params[s].nil?
        xml.service{xml.text s}
      end
    end
  end
end
