<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="RewardPoint.aspx.cs" Inherits="Assignment.RewardPoint" %>
<asp:Content ID="rewardPoint" ContentPlaceHolderID="main" runat="server">
    
    <div class="RP d-flex flex-wrap">
        <div class="RP-left" style="flex:1;">
            <div class="RPHeader">
                <h2>Welcome to 
                <br /><span class="RPHeader-1">Reward Point</span>
                </h2>
            </div>
            <div class="RPHeader-Bottom" style="flex: 1;">
                <p>
                    Hi, 
                    
                <asp:Label ID="lblUsername" runat="server" Text="[Username]"></asp:Label>
                </p>

                <p class="ex-1">
                    <asp:Label ID="lblExpiryPoints" runat="server" Text="[Points]" CssClass="ex-2"></asp:Label> Points will be expired at <asp:Label ID="lblExpiryDate" runat="server" Text="[Expriy Date]" CssClass="ex-3"></asp:Label>
                </p>

                <p>
                    <asp:Label ID="lblTotalPoints" runat="server" Text="[Total Points]"></asp:Label>
                </p>

                <asp:Button ID="btnRedeem" runat="server" Text="Reward" CssClass="btn btn-success" OnClick="btnRedeem_Click"/>
            </div>
        </div>

        <div class="RP-right";>
            <div class="right-upperside">
                <!-- a tag trigger modal -->
                <a href="#" class="" data-bs-toggle="modal" data-bs-target="#History">Points History</a>
            </div>
            
            <div class="right-lowerside-1">
                <div class="right-lowerside-2">
                    <img src="../Image/RewardPoint/bg-5.png" class="RPImage" />
                </div>
            </div>
           
        </div>
    </div>
    
    <!-- Modal -->  
    <div class="modal modal-lg fade" id="History" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content custom-history-modal">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">My Points</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h5>5260 Points</h5>
                    <p>Points expire 12 months after they were earned</p>
                    <hr>
                    <h5>Points history</h5>
                    <br />
                    <div class="d-flex justify-content-between">
                        <div style="flex:10%"><i class="fa-solid fa-caret-up" style="color: #398000;"></i></div>
                        <div style="flex:80%">
                            <div>Earned</div>
                            <div>2024-08-09</div>
                        </div>
                        <div style="flex:10%">1000 &nbsp; <i class="fa-solid fa-coins" style="color: #eb8900;"></i></div>
                    </div>
                    <br />
                    <div class="d-flex justify-content-between">
                        <div style="flex:10%"><i class="fa-solid fa-caret-down" style="color: #e00000;"></i></div>
                        <div style="flex:80%">
                            <div>Used</div>
                            <div>2024-08-10</div>
                        </div>
                        <div style="flex:10%">-1000 &nbsp; <i class="fa-solid fa-coins" style="color: #eb8900;"></i></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
