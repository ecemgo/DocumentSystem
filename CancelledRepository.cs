using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CMS.Core;
using CMS.Core.Interfaces;
using CMS.Core.Models;
using PetaPoco;

namespace CMS.Infrastructure.Repositories
{
    public class CancelledRepository :ICancelledRepository
    {
        Database CMS = new Database("CMSConnection");

        public void Add(Core.Models.Cancelled cancelledRecord)
        {
            CMS.Insert(cancelledRecord);
        }

        public void Edit(Core.Models.Cancelled cancelledRecord)
        {
            CMS.Update(cancelledRecord);
        }

        public Core.Models.Cancelled FindCancelledByID(int cancelledID)
        {
            var c =  CMS.Single<Core.Models.Cancelled>(cancelledID);
            return c; 
        }
		
		
		 public Core.Models.Cancelled FindCancelledByDocument(Guid documentGUID)
        {
            var c =  CMS.Single<Core.Models.Cancelled>(documentGUID);
            return c; 
        }


        public IEnumerable<Core.Models.Cancelled> ListCancelled()
        {
            var c = CMS.Query<Core.Models.Cancelled>("select * from Cancelled");
            return c;
        }

        public void Remove(int cancelledRecordID)
        {
            CMS.Delete(cancelledRecordID);
        }
    }
}
